---
title: Glossary
description: Glossary of terms based on the Nexicon
---

Term | Description
--- | ---
2FA | <p>Two-factor authentication: unambiguous identification of users by means of the combination of two different components. For example, to withdraw cash from an ATM, you need both a card and a pin code. These components may be something that the user knows, something that the user possesses or something that is inseparable from the user.</p><p>Many Nexmo customers authenticate their users by sending them a pin code in an SMS. The user authenticates by entering the PIN into the customer's UI. For example, password reset. In this case the two components are the account details, and possession of the phone number registered to that account.</p><p>See the [Wikipedia article](https://en.wikipedia.org/wiki/Two-factor_authentication).</p>
A2P	| Application to Person
Adaptive Routing(™) | <p>Adaptive Routing technology actively reroutes messages through the alternate carrier routes to ensure that messages are delivered in an optimal manner. It identifies the aggregator partners that are providing the best performance to a given destination, and as a result, both latency and performance volatility are reduced.</p><p>This technology in the Platform is an algorithm that actively monitors and dynamically adjusts the routes used to deliver SMS. The route choice is made using millions of real-time conversion data points.</p>
AD | Admin Dashboard. See Glossary#Dashboard.
Analytics | Use Nexicon Glossary#insights.
Android Virtual Device | A device configuration that is run with the Android emulator. For more information, see http://developer.android.com/tools/devices/index.html.
API	| API, which stands for Application Program Interface, is a set of protocols, tools and routines for building applications. An API specifies how the various software components interact.  Nexmo’s Cloud Communications Platform provides a comprehensive suite of APIS than allow you to implement Messaging, Voice, Verification, and Chat App API solutions. 
App | Software that runs on a computer, mobile device or a Web browser. See https://en.wikipedia.org/wiki/App.
Application | Deprecated, use Nexicon (Glossary)#App.
AR | See Adaptive Routing.
ARDW | Adaptive Routing Dynamic Weights. See Adaptive Routing.
ASR | The Answer Seizure Ratio is a metric used to measure the quality of a carrier’s network. The ASR calculation is `Number of successfully answered calls / Number of calls received`.
AVD	| See Android Virtual Device.
BI | See Business Intelligence
Business Intelligence | Team managing data and analytical tools, such as Tableau Server (bi.nexmo.com) or Data warehouse. See their Confluence space for more details.
Call API | You use Call API to generate voice calls over regular phone numbers. You can: <ul><li>Create Call me buttons.</li><li>Automate calls in your App.</li><li>Manage event-prompted calls.</li></ul>Call API is part of Voice API.
Caller ID | The Sender ID for Voice Calls.
Carrier | A Telecommunications Service Provider. The company that a phone connects to is the target carrier for the phone number. You can also have intermediate carriers - Nexmo is one.
CDR | Call Detail Record. CDRs completely describe a message or call and the submission state. Technically, this is data for a particular Request.
Challenge | See Challenge-response.
Challenge-response | A family of protocols in which one party presents a question ("challenge") and another party must provide a valid answer ("response") in order to be authenticated. See [Wikipedia article](https://en.wikipedia.org/wiki/Challenge–response_authentication.)
Chat App API | Supplies two-way messaging with users of all different chat apps, plus access to data about the users’ profiles. Chat App API gives access to all the chat apps in one place after a single integration.
CLI | See Caller ID.
Cloud number | A virtual number that is assigned to a customers account and not a device. A virtual number can accept inbound SMS, Voice or both. Nexmo customers use these numbers for Nexicon (Glossary)#Messaging or Nexicon (Glossary)#Voice communication.
Conversions | The successful validation that a message was delivered to a user.
Customer | A company who uses Nexmo products or services.
CD | Customer Dashboard. See Nexicon (Glossary)#Dashboard.
DA | Destination Address. Receiving number or equivalent.
Dashboard | This product is a self-service customer tool. You use your Dashboard to: <ul><li>Manage your account:</li><ul><li>Secondary users</li><li>TopUps</li><li>Notifications</li><li>Profile</li></ul><li>Manage your products:</li><ul><li>Virtual numbers</li><li>US Short Codes</li></ul><li>Analyse the success rates for your communication using the Nexmo APIs:</li><ul><li>Measure conversion</li><li>Track and troubleshoot message delivery</li><li>Make data-driven decisions</li><li>Optimize communication with their users</li></ul>
Dedicated Short Codes | This is a Short Code used by a single Nexmo Customer. Unlike a Shared Short Code, Nexmo manages a lengthy application process in order to purchase a US short code for you. Customers can also transfer their current short code to Nexmo.
Delivery Receipt | When Nexmo sends an SMS to a Telecommunications Service Provider, they return a delivery receipt. Telecommunications Service Providers send the delivery receipt at a moment of their choice, they do not have to wait for delivery confirmation.<p>Delivery receipt can be either:</p><ul><li>Carrier - returned to Nexmo when the message is received by the Telecommunications Service Providers.</li><li>Handset - returned to Nexmo when the message is received on your user's handset.</li></ul><p>In practice, some Telecommunications Service Providers either do not send the delivery receipt or send a Fake DLR. We cannot be 100% certain that a "successfully delivered" delivery receipt means that the message reached the user.</p><p>If the message is not received, this delivery receipt explains why the message failed to arrive.</p>
Destination Number | The phone number a message or call is sent to. This is the to parameter in the Nexmo APIs.
Developer API | The API you use to manage your Nexmo account.
Direct downloadable link | A direct downloadable link provides a hyperlink that points to a location within the Internet where the user can download a file.
Direct-to-Carrier Network | The Platform is a globally distributed communication network based on direct integration with Telecommunications Service Providers. This provides zero-hop communication to most destinations worldwide. This results in lower latency and higher quality of delivery.
DLR | See Nexicon (Glossary)#Delivery Receipt.
DN | See Nexicon (Glossary)#Delivery Receipt.
DR | See Nexicon (Glossary)#Delivery Receipt.
DTMF | Dual Tone Multi Frequency. See [Wikipedia article](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling).
Dynamic caller ID | Enables you to present any phone number on your account as your outbound Caller ID. You can have multiple Caller IDs based on the number you are calling. For example, if you call someone in San Francisco from New York City, the recipient would only see a local San Francisco number on their phone.
Dynamic phone number insertion | A measure of the impact of inbound phone calls in digital marketing efforts. For example, when a potential customer clicks on your site, dynamic phone number insertion will show a phone numbers that is unique to the  search engine, website, key terms or other source.
Dynamic Routing | See Adaptive Routing.
Extended shortcode | A short number between 4 and 6 digits that has been extended to create a large quantity of numbers.
Fake Delivery Receipt | <p>A Nexicon (Glossary)#Delivery Receipt suspected to be fake. That is, when there is no intention to deliver the SMS. In cases of filtering, this usually occurs in the Middle East.</p><p>Sometimes delivery receipts are faked because the Telecommunications Service Provider sends it early. Some Telecommunications Service Providers never return a delivery receipt. In this case Nexmo creates a delivery receipt and sends it to you.</p>
Enterprise-grade call quality | Ensures that your communications network provides high-quality voice traffic. Call quality is never less than that of a major Telecommunications Service Provider.
Geo	| The geographic region of the world.
GSM	| See [Wikipedia article](https://en.wikipedia.org/wiki/GSM).
Handset Delivery Receipt | A Nexicon (Glossary)#Delivery Receipt that is sent when the message is delivered to the user's handset.
HLR | Home Location Register. These databases contain details of each subscriber phone number, including the current active status and more.
HTTP | An application protocol for distributed, collaborative, hypermedia information systems. HTTP is the foundation of data communication for the Nexicon (Glossary)#Web, it is the most common standard internet communication protocol. See [Wikipedia article](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol).
HTTPS | The secure version of Nexicon (Glossary)#HTTP. See [Wikipedia article](https://en.wikipedia.org/wiki/HTTPS).
Inactive number | A phone number that is no longer active.
Inbound message | An SMS sent as a reply to the originator.
Inbound number | Make it easy for your users to call you and route calls.
Inbound SMS | A simple, cost-effective way to interact with your users. They can send SMS to you using a virtual number.
Insights | Reliable data collected for specific goals.
Interactive Voice Response (IVR) | An automated telephony technology that enables a human caller to interact with a computer using voice and DTMF tones input on a keypad.
Intermediate carrier | A Telecommunications Service Provider that does not own the wireless network infrastructure. See [Wikipedia article](https://en.wikipedia.org/wiki/Mobile_virtual_network_operator).
Internet | The Internet is a global system of interconnected computer networks that use the standard Internet protocol suite (TCP/IP) to link several billion devices worldwide. It is a network of networks. See [Wikipedia](https://en.wikipedia.org/wiki/Internet).
IVR | See Interactive Voice Response.
JSON | A data format. When you make a request against the Nexmo APIs, you can choose to send and/or receive data in JSON format. See [Wikipedia article](https://en.wikipedia.org/wiki/JSON).
Latency | The elapsed time between the moment a message is sent and when it is received. A delivery that encounters few or no delays has low latency. A delivery that encounters a significant amount of delay has high latency. The greater the number of hops associated with message delivery, the greater the number of opportunities for delay — and higher latency.
Live Handset Check | See Nexicon (Glossary)#HLR.
Local Supplier | An intermediate carrier we believe has direct connections Telecommunications Service Providers in a country.
Low friction integration | Allows you to build conferencing apps that scale with dynamic phone number provisioning and call control for improved experience.
LVN | Use Virtual Number.
Meshed carrier network | A seamless network of Telecommunications Service Providers. This enables you to pick and choose Telecommunications Service Providers for each location. This gives maximum flexibility and savings compared to MPLS or Wide Area Networking solutions.
Messaging | <p>This product enables Nexmo customers to have a conversation with their users. The products that make up Messaging are:</p><p><ul><li>SMS API</li><li>US Short Codes API</li><li>SMS Cloud Numbers</li></ul></p>
Metrics	| Use Nexicon (Glossary)#insights.
MO | Mobile Originated. Sent from a phone number to Nexmo. When a phone sends a text to a virtual number it is MO because the message originates from the phone.
MT | Mobile Terminated. That is, sent by a customer to a phone number through the Platform. For example, requests to deliver an SMS are MT, they go to a phone number.
Network	| A Telecommunications Service Provider.
Network Delivery Receipt | A Nexicon (Glossary)#Delivery Receipt.
Nexmo | Nexmo offers the most advanced solutions to organizations who need to easily embed scalable and trusted communications into their applications and business processes. Nexmo customers communicate with their users through the Platform.
Nexmo Dashboard | Use Nexicon (Glossary)#Dashboard.
Notification service | Provides the means to send a notice to many persons at once. See https://en.wikipedia.org/wiki/Notification_Service.
Number Cloud | <p>Using Number Cloud you check and retrieve information about phone numbers. It includes:</p><ul><li>Number Insight API</li><li>Verify API</li></ul>
Number Insight API | <p>A group of products in the Number Cloud that provides actionable intelligence on phone numbers without interfering with the end-user experience. Number Insight is made up of:</p><ul><li>Number Insight Basic</li><li>Number Insight Standard</li><li>Number Insight Advanced</li></ul>
Number Insight Basic | This Number Insight product is an synchronous API that returns local and international representations of a phone number. Use this API to pretty-print numbers in a UX.
Number Insight Standard | This Number Insight product is an synchronous API that identifies the Telecommunications Service Provider network a number belongs to and the number type. Use this API to ensure that you are dealing with a real phone number that is semantically correct. This API also supplies the functionality in Number Insight Basic.
Number Insight Advanced | This  Number Insight  product is an synchronous API that verifies the relationship between a phone number and the Telecommunications Service Providers that have supplied it.
Number inventory | Search for, buy and update your inventory of numbers using Nexmo Dashboard.
Number validity | Determine if the numbers in your database are valid according to local numbering plans and portability databases.
Operator | See Telecommunications Service Provider.
OA | Originating Address see SenderID or the MSISDN of the sender
Originating Number | See Sender ID.
PDD | <p>Post-Dial Delay is the time it takes to receive feedback after a user has finished dialling. This feedback is either a:</p><ul><li>Dial tone</li><li>Recorded announcement</li><li>Abandoned call</li></ul>
P2P | Person to Person
Per second billing | With Nexmo per second billing, you maintain full control over how much you spend. For example, if your call lasts 2.5 minutes, you are charged for 2.5 minutes, not 3. This billing model allows you to make more calls for the same amount of money.
Performance volatility | The frequent changes in throughput that constantly occur in SMS networks. For example, the fastest and most reliable network connection to a Telecommunications Service Providers may suddenly become unavailable, in which case alternate routes must be immediately switched to.
PIN | A numeric password shared between a user and a system that can be used to authenticate the user to the system. See [Wikipedia article](https://en.wikipedia.org/wiki/Personal_identification_number).
Platform | <p>The Nexmo technologies that facilitate the interaction between Nexmo customers and their users. The Cloud Communications Platform is an API based, fully redundant global communication platform that delivers mission critical multi-channel solutions. The main products in the cloud are:</p><ul><li>Technologies - the components and algorithms that make the Platform work:<ul><li>Direct-to-Carrier Network</li><li>Adaptive Routing(™)</li><li>Platform Infrastructure</li></ul></li><li>Services - Customers communicate with the cloud using the comprehensive suite of Nexmo APIs in order to optimize their communication experience. These APIs are:<ul><li>Nexicon (Glossary)#Messaging</li><li>Nexicon (Glossary)#Voice</li><li>Nexicon (Glossary)#Number Cloud</li><li>Developer API</li></ul></li><li>Virtual Numbers - phone numbers that customers rent:<ul><li>SMS Cloud Numbers</li><li>Voice Cloud Numbers</li><li>Shared Short Codes</li><li>Dedicated Short Codes</li></ul></li></ul><p>Customers interact and manage their account in the Platform using the Nexicon (Glossary)#Dashboard.</p>
Phone number | The number that is either a [telephone number](https://en.wikipedia.org/wiki/Telephone_number) or a virtual number.
Ported Phone Number | When somebody changes Telecommunications Service Provider but keeps the same phone number. As a ported phone is registered with another Telecommunications Service Provider, the reliability of delivery is reduced.
Premium number | Used when certain services are provided over the phone. Part of the call charge is paid to the service provider, this enables businesses to be funded through calls to the premium number.
PSTN | See public switched telephone network
Presence |If the phone number associated with a user is currently reachable. You use this to see if a user is available to receive information. For example, an SMS or Voice message.
Read rate | The number of times a user opened the message you sent. SMS has a 95% read rate, most inbound messages are read within 90 seconds of arrival.
Request | A call to the APIs offered by Nexmo.
Response | After you send a Request, the response returns the the status and cost of your Request to the Nexmo API. Depending on your Request, the Response is in either JSON or XML format.
REST | An architectural style of remote execution applied over HTTP. REST is not completely defined, many people refer to remote requests using HTTP as REST requests. See [Wikipedia article](https://en.wikipedia.org/wiki/Representational_state_transfer).
Rich interaction | The interface model for a rich client. This interaction model supports several input methods and that responds intuitively and in a timely fashion.
Roaming | When a phone number is outside its Telecommunications Service Provider network and it remains connected in another Telecommunications Service Provider network. This only happens if roaming is enabled on the phone. See [Wikipedia article](https://en.wikipedia.org/wiki/Roaming).
RTP | Media protocol used for transfer of voice data once a Voip call is established.
Sender ID | The phone number or message shown on a handset when it receives an SMS API or Voice API message.
Shared Short Codes | A Short Code that is instantly available to Customers. These US Short Codes are shared with other customers.
Short Code | Special telephone numbers, significantly shorter than full telephone numbers, that can be used to address SMS. For more information, see [Wikipedia article](https://en.wikipedia.org/wiki/Short_code).
Short Message Service | A text messaging service component of phone, Web, or mobile communication systems. See [Wikipedia](https://en.wikipedia.org/wiki/Short_Message_Service).
Silent ping	| A silent SMS sent to check if a user's phone is turned on. If the user's device is not turned on when the ping SMS is sent, you receive a notification as soon as the device is turned on.
SIP | Session Initiation Protocol (SIP) is an application-layer control protocol that can establish, modify, and terminate multimedia sessions (conferences) such as Internet telephony calls. Nexmo supports a SIP interface for Nexicon (Glossary)#Voice. See [Wikipedia article](https://en.wikipedia.org/wiki/Session_Initiation_Protocol).
SIP Trunking | In Nexicon (Glossary)#Voice, some customers connect to the Nexmo Nexicon (Glossary)#SIP enpoint ( sip.nexmo.com) to create and accept inbound and outbound VOIP calls. All requests are digest authenticated using account credentials. You can use this flexible as a SIP trunk and a SIP User Agent gateway.
SMPP | The Short Message Peer-to-Peer (SMPP) protocol is used to communicate Nexicon (Glossary)#SMS between carriers. Nexicon (Glossary)#Nexmo supports SMPP. However, the majority of our customers use the Nexicon (Glossary)#HTTP interface.
SMS | See Short Message Service.
SMS API | A Nexicon (Glossary)#Messaging API you use to send and receive a high volume of Nexicon (Glossary)#SMS anywhere in the world. The SMS API provides instant access to the highest quality global messaging network. The SMS API uses Adaptive Routing and delivery optimization technologies to ensure the highest quality message delivery.
SMS Cloud Numbers | Cloud numbers enabled to receive Nexicon (Glossary)#SMS.
SMS-Enabled Virtual Number | See SMS Cloud Numbers.
Stochastic | Events or systems that are unpredictable due to the influence of a random variable. See [Wikipedia](https://en.wikipedia.org/wiki/Stochastic).
Supplier | Any company furnishing telecoms services to Nexmo that does not fit into the category of carrier or intermediate carrier.
Target Carrier | The carrier that a phone number is currently connected to.
Telecommunications Service Provider | A type of communications service provider that has traditionally provided telephone and similar services. This category includes incumbent local exchange carriers, competitive local exchange carriers, and mobile wireless communication companies.
Trace ID | Proposed id code for an API request to be in all logs that the API request triggers, used for linking of related logs
TSP | See Telecommunications Service Provider.
TTS API | <p>You use the Nexicon (Glossary)#TTS API to play synthesized messages and audio files to a live call. Using this API you can:</p><ul><li>Specify the language to use for synthesized speech</li><li>Change the cadence of the synthesized speech to speed up or slow down the voice</li><li>Specify the URL of the media file for streaming audio</li><li>Repeat a message up to 10 times</li><li>Change the gender of the voice</li></ul><p>TTS API is part of Voice API.</p>
TTS Prompt API | <p>You use the Nexicon (Glossary)#TTS Prompt API to:</p><ul><li>Collect digits following a TTS message</li><li>Collect digits for Nexicon (Glossary)#2FA</li><li>Set a message to be played after users have entered digits</li><li>Play a message after 3 failed Nexicon (Glossary)#PIN entries</li></ul><p>TTS Prompt API is part of Voice API.</p>
Two-way messaging | Send and receive SMS directly from your system or App.
User | A person that uses a customer's services. A user is associated with a phone number.
US Short Codes API | <p>You use Nexmo's US Short Codes API to:</p><ul><li>Prove a user's identity with Two-factor Authentication.</li><li>Communicate with people using Event Based Alerts.</li></ul>
Verify API | <p>A turnkey, pay-per-conversation phone verification solution that allows you to instantly verify users globally and achieve highest conversion in order to:</p><ul><li>Easily register users</li><li>Verify transactions</li><li>Implement Nexicon (Glossary)#2FA and one-time passwords</li></ul>
Virtual number | A virtual number such as `+44 7624 80055` in international notation or `757-772-8555` in typical U.S. notation. Nexmo purchases virtual numbers from various carriers. Nexmo customers rent these virtual numbers to receive inbound messages and voice communication in their Nexicon (Glossary)#App. See [Long Number](https://en.wikipedia.org/wiki/Long_number) and [Virtual Number](https://en.wikipedia.org/wiki/Virtual_number).
Voice | <p>A suite of API’s used to build voice enabled apps. These products allow customers to integrate text-to-speech into their workflow, build interactive voice response systems using Nexicon (Glossary)#VXML or make VOIP calls using Nexicon (Glossary)#SIP trunks.</p><p>Voice includes:</p><ul><li>Voice API</li><li>SIP Trunking</li><li>Voice Enabled Numbers (LVNS)</li></ul>
Voice API | <p>This Nexicon (Glossary)#Voice product provides a simple and affordable personalized voice communication experience.</p><p>Voice API contains:</p><ul><li>Call API - generate voice calls over regular phone numbers</li><li>TTS API - play synthesized messages and audio files to a live call</li><li>TTS Prompt API -  Collect digits following a TTS message</li></ul>
Voice Cloud Numbers | Cloud numbers enabled to send and receive Nexicon (Glossary)#Voice messages.
Voice-Enabled Landline Virtual Number | An virtual number tied to a landline that you can send voice data to.
Voice-Enabled Toll-Free Virtual Number | A  Voice-Enabled Landline Virtual Number designated as Freephone. That is, calls to this LVN from within the local country are free for the caller.
VoiceXML | A digital document standard for specifying interactive media and voice dialogs between humans and computers. See [Wikipedia article](https://en.wikipedia.org/wiki/VoiceXML).
VOIP | A methodology and group of technologies for delivering voice communications and multimedia sessions over Internet Protocol (IP) networks. See [Wikipedia article](https://en.wikipedia.org/wiki/Voice_over_IP).
VXML | See Nexicon (Glossary)#VoiceXML.
Web | An information system of interlinked hypertext documents and other digital resources that are accessed via the Nexicon (Glossary)#Internet. See [Wikipedia article](https://en.wikipedia.org/wiki/World_Wide_Web).
XML | A data format. When you make a request against the Nexmo APIs, you can choose to receive data in XML format. See [Wikipedia article](https://en.wikipedia.org/wiki/XML).
