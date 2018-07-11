---
title: NCCO reference
description: The Nexmo Call Control Objects used to manage your Voice API calls.
api: "Voice API: NCCO"
---

# NCCO reference

A Nexmo Call Control Object (NCCO) is a JSON array that you use to control the flow of a Voice API call. For your NCCO to execute correctly, the JSON objects must be valid.

The order of actions in the NCCO controls the flow of the Call. Actions that have to complete before the next action can be executed are *synchronous*. Other actions are *asynchronous*. That is, they are supposed to continue over the following actions until a condition is met. For example, a `record` action terminates when the `endOnSilence` option is met. When all the actions in the NCCO are complete, the Call ends.

The NCCO actions and the options and types for each action are:

Action | Description | Synchronous
-- | -- | --
[record](#record) | All or part of a Call | No
[conversation](#conversation) | A standard or hosted conference. | Yes
[connect](#connect) | To a connectable endpoint such as a phone number. | Yes
[talk](#talk) | Send synthesized speech to a Conversation. | Yes, unless *bargeIn=true*
[stream](#stream) | Send audio files to a Conversation. | Yes, unless *bargeIn=true*
[input ](#input) | Collect digits from the person you are calling. | Yes

All the actions can return the following [status codes](#status-codes).

> **Note**: [Controlling a Call with Nexmo Call Control Objects](/voice/guides/ncco#controlling) explains how to provide your NCCOs to Nexmo after you initiate a Call or Conference.

While developing and testing NCCOs, you can use the Voice Playground to try out NCCOs interactively. You can [read more about it in the Voice API Overview](/voice/voice-api/overview#voice-playground) or [go directly to the Voice Playground in the Dashboard](https://dashboard.nexmo.com/voice/playground).

## Record

Use the `record` action to record a Call or part of a Call:

```json
[
  {
    "action": "record",
    "eventUrl": ["https://example.com/recordings"]
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "from":"447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```

The record action is asynchronous. Recording starts when the record action is executed in the NCCO and finishes when the synchronous condition in the action is met. That is, `endOnSilence`, `timeOut` or `endOnKey`. If you do not set a synchronous condition, the Voice API immediately executes the next NCCO without recording.

For information about the workflow to follow, see [Recordings](/voice/guides/record-calls-and-conversations).

You can use the following options to control a `record` action:

Option | Description | Required
 -- | -- | --
`format` | Record the Call in a specific format.  Options are: <ul><li>mp3</li><li>wav</li></ul> The default value is *mp3*. | No
`split` | Record the sent and received audio in separate channels of a stereo recording—set to `conversation` to enable this.| No
`endOnSilence` | Stop recording after n seconds of silence. Once the recording is stopped the recording data is sent to *event_url*. The range of possible values is *3<=endOnSilence<=10*. | No
`endOnKey` | Stop recording when a digit is pressed on the handset. Possible values are: `*`, `#` or any single digit e.g. `9` | No
`timeOut` | The maximum length of a recording in seconds. One the recording is stopped the recording data is sent to *event_url*. The range of possible values is between `3` seconds and `7200` seconds (2 hours) | No
`beepStart` | Set to *true* to play a beep when a recording starts | No
`eventUrl` | The URL to the webhook endpoint that is called asynchronously when a recording is finished. If the message recording is hosted by Nexmo, this webhook contains the [URL you need to download the recording and other meta data](#recording_return_parameters). | No
`eventMethod` | The HTTP method used to make the request to `eventUrl`. The default value is `POST`. | No

<a name="recording_return_parameters"></a>
The following example shows the return parameters sent to `eventUrl`:

```json
{
  "start_time": "2020-01-01T12:00:00Z",
  "recording_url": "https://api.nexmo.com/media/download?id=aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "size": 12345,
  "recording_uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "end_time": "2020-01-01T12:01:00Z",
  "conversation_uuid": "bbbbbbbb-cccc-dddd-eeee-0123456789ab",
  "timestamp": "2020-01-01T14:00:00.000Z"
}
```

Possible return parameters are:

 Name | Description
 -- | --
 `recording_uuid` | The unique ID for the Call. <br>**Note**: `recording_uuid` is not the same as the file uuid in *recording_url*.
 `recording_url` | The  URL to the file containing the Call recording. To download a recording, see [Record calls and conversations](/voice/guides/record-calls-and-conversations).
 `start_time`  | The time the recording started in the following format: `YYYY-MM-DD HH:MM:SS`. For example `2020-01-01 12:00:00`
 `end_time`  | The time the recording finished in the following format: `YYYY-MM-DD HH:MM:SS`. For example `2020-01-01 12:00:00`
 `size` | The size of the recording at *recording_url* in bytes. For example: `603423`
 `conversation_uuid` | The unique ID for this Call.

## Conversation

You can use the `conversation` action to create standard or moderated Conversations. The first person to call the virtual number assigned to the Conversation creates it. This action is synchronous, the Conversation lasts until the number of participants is 0.

> **Note**: you can invite up to 50 people to your Conversation.

The following NCCO examples show how to configure different types of Conversation. You can use the [*answer_url* webhook GET request parameters](/voice/guides/ncco#controlling) to ensure you deliver one NCCO to participants and another to the moderator.

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/conversation'
```

You can use the following options to control a *conversation* action:

Option | Description | Required
-- | -- | --
`name` | The name of the Conversation room. Names have to be unique per account. | Yes
`musicOnHoldUrl` | A URL to the *mp3* file to stream to participants until the conversation starts. By default the conversation starts when the first person calls the virtual number associated with your Voice app. To stream this mp3 before the moderator joins the conversation, set *startOnEnter* to *false* for all users other than the moderator. | no
`startOnEnter` | The default value of *true* ensures that the conversation starts when this caller joins  conversation [name](#conversation_name). Set to *false* for attendees in a moderated conversation. | no
`endOnExit` | For moderated conversations, set to *true* in the moderator NCCO so the conversation is ended when the moderator hangs up. The default value of *false* means the conversation is not terminated when a caller hangs up; the conversation ends when the last caller hangs up. | no
`record` | Set to *true* to record this conversation. For standard conversations, recordings start when one or more attendees connects to the conversation. For moderated conversations, recordings start when the moderator joins. That is, when an NCCO is executed for the named conversation where *startOnEnter* is set to *true*. When the recording is terminated, the URL you download the recording from is sent to the event URL. <br>By default audio is recorded in MP3 format. See [Recording calls and conversations](/voice/guides/record-calls-and-conversations). | No
`eventUrl` | Set the URL to the webhook endpoint Nexmo calls asynchronously on each of the call [states](/api/voice#status). | No
`eventMethod` | Set the HTTP method used to make the request to `eventUrl`. The default value is POST. | No

<a name="connect"></a>
## Connect

You can use the `connect` action to connect a call to endpoints such as phone numbers.

This action is synchronous, after a *connect* the next action in the NCCO stack is processed. A connect action ends when the endpoint you are calling is busy or unavailable. You ring endpoints sequentially by nesting connect actions.

You can use the following options to control a `connect` action:

Option | Description | Required
-- | -- | --
`endpoint` | Connect to a single endpoint. @[Possible Types](/_modals/voice/guides/ncco-reference/endpoint.md) | Yes
`from` | A number in [E.164](https://en.wikipedia.org/wiki/E.164) format that identifies the caller.§§ This must be one of your Nexmo virtual numbers, another value will result in the caller ID being unknown. | No
`eventType` | Set to `synchronous` to: <ul markdown="1"><li>make the `connect` action synchronous</li><li>enable `eventUrl` to return an NCCO that overrides the current NCCO when a call moves to specific states. See the [Connect with fallback NCCO example](#connect-with-fallback-ncco).</li></ul> | No
`timeout` |  If the call is unanswered, set the number in seconds before Nexmo stops ringing `endpoint`. The default value is `60`.
`limit` | Maximum length of the call in seconds. The default and maximum value is `7200` seconds (2 hours). | No
`machineDetection` | Configure the behavior when Nexmo detects that a destination is an answerphone. Set to either: <ul markdown="1"><li>`continue` - Nexmo sends an HTTP request to `event_url` with the Call event `machine`</li><li>`hangup` - end the Call</li></ul>   |
`eventUrl` | Set the webhook endpoint that Nexmo calls asynchronously on each of the possible [Call states](/api/voice#status). If `eventType` is set to `synchronous` the `eventUrl` can return an NCCO that overrides the current NCCO when a timeout occurs. | No
`eventMethod` | The HTTP method Nexmo uses to make the request to <i>eventUrl</i>. The default value is `POST`. | No

### Examples

The following NCCO examples show how to configure different types of connection:

* [Connect to a PSTN endpoint](#connect-to-a-pstn-endpoint)
* [Connect to a WebSocket endpoint](#connect-to-a-websocket-endpoint)
* [Connect with fallback NCCO](#connect-with-fallback-ncco)
* [Connect to a SIP endpoint](#connect-to-a-sip-endpoint)
* [Recorded proxy call](#recorded-proxy-call)

#### Connect to a PSTN endpoint

```json
[
  {
    "action": "talk",
    "text": "Please wait while we connect you"
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "timeout": "45",
    "from": "447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001",
        "dtmfAnswer": "2p02p"
      }
    ]
  }
]
```

#### Connect to a WebSocket endpoint

```json
[
  {
    "action": "talk",
    "text": "Please wait while we connect you"
  },
  {
    "action": "connect",
    "eventUrl": [
      "https://example.com/events"
    ],
    "from": "447700900000",
    "endpoint": [
    {
      "type": "websocket",
      "uri": "ws://example.com/socket",
      "content-type": "audio/l16;rate=16000",
      "headers": {
        "whatever": "metadata_you_want"
        }
      }
    ]}
]
```

#### Connect with fallback NCCO

You can provide a fallback for Calls that do not connect. To do this set the `eventType` to `synchronous` and return an NCCO from the `eventUrl` if the Call enters any of the following states:

* `timeout` - your user did not answer your call with `ringing_timer` seconds
* `failed` - the call failed to complete
* `rejected` - the call was rejected
* `unanswered` - the call was not answered
* `busy` - the person being called was on another call

```json
[
  {
    "action": "connect",
    "from": "447700900000",
    "timeout": 5,
    "eventType": "synchronous",
    "eventUrl": [
      "https://example.com/event-fallback"
    ],
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```

#### Connect to a SIP endpoint

```json
[
  {
    "action": "talk",
    "text": "Please wait while we connect you"
  },
  {
    "action": "connect",
    "eventUrl": [
      "https://example.com/events"
    ],
    "from": "447700900000",
    "endpoint": [
      {
        "type": "sip",
        "uri": "sip:rebekka@sip.mcrussell.com"
      }
    ]
  }
]
```

#### Recorded proxy call

```json
[
  {
    "action": "record",
    "eventUrl": ["https://example.com/recordings"]
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "from": "447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```

## Talk

The `talk` action sends synthesized speech to a Conversation.

The text provided in the talk action can either be plain, or formatted using [SSML](/voice/voice-api/guides/ssml). SSML tags provide further instructions to the text-to-speech synthesiser which allow you to set pitch, pronunciation and to combine together text in multiple languages. SSML tags are XML-based and sent inline in the JSON string.

By default, the talk action is synchronous. However, if you set *bargeIn* to *true* you must set an *input* action later in the NCCO stack.
The following NCCO examples shows how to send a synthesized speech message to a Conversation or Call:

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/talk'
```

You can use the following options to control a *talk* action:

| Option | Description | Required |
| -- | -- | -- |
| `text` | A string of up to 1,500 characters (excluding SSML tags) containing the message to be synthesized in the Call or Conversation. A single comma in `text` adds a short pause to the synthesized speech. To add a longer pause a `break` tag needs to be used in SSML. To use [SSML](/voice/voice-api/guides/ssml) tags, you must enclose the text in a `speak` element. | Yes |
| `bargeIn` | Set to `true` so this action is terminated when the user presses a button on the keypad. Use this feature to enable users to choose an option without having to listen to the whole message in your <a href="/voice/voice-api/guides/interactive-voice-response">Interactive Voice Response (IVR)</a>. If you set `bargeIn` to `true` the next action in the NCCO stack <b>must</b> be an `input` action. The default value is `false`. | No |
| `loop` | The number of times `text` is repeated before the Call is closed. The default value is 1. Set to 0 to loop infinitely. | No |
| `level` | The volume level that the speech is played. This can be any value between `-1` to `1` with `0` being the default.  | No |
| `voiceName` | The name of the voice used to deliver `text`. You use the voiceName that has the correct language, gender and accent for the message you are sending. For example, the default voice `kimberly` is a female who speaks English with an American accent (en-US). Possible values are listed below. | No |

### Voice names

Name | Language | Gender | SSML support
-- | -- | -- | -- 
`Salli` | `en-US` | `female` | ✅
`Joey` | `en-US` | `male` | ✅
`Naja` | `da-DK` | `female` | ✅
`Mads` | `da-DK` | `male` | ✅
`Marlene` | `de-DE` | `female` | ✅
`Hans` | `de-DE` | `male` | ✅
`Nicole` | `en-AU` | `female` | ✅
`Russell` | `en-AU` | `male` | ✅
`Amy` | `en-GB` | `female` | ✅
`Brian` | `en-GB` | `male` | ✅
`Emma` | `en-GB` | `female` | ✅
`Gwyneth` | `en-GB` | `WLS female` | ✅
`Geraint` | `en-GB` | `WLS male` | ✅
`Gwyneth` | `cy-GB` | `WLS female` | ✅
`Geraint` | `cy-GB` | `WLS male` | ✅
`Raveena` | `en-IN` | `female` | ✅
`Ivy` | `en-US` | `female` | ✅
`Justin` | `en-US` | `male` | ✅
`Kendra` | `en-US` | `female` | ✅
`Kimberly` | `en-US` | `female` | ✅
`Joanna` | `en-US` | `female` | ✅
`Conchita` | `es-ES` | `female` | ✅
`Enrique` | `es-ES` | `male` | ✅
`Penelope` | `es-US` | `female` | ✅
`Miguel` | `es-US` | `male` | ✅
`Chantal` | `fr-CA` | `female` | ✅
`Celine` | `fr-FR` | `female` | ✅
`Mathieu` | `fr-FR` | `male` | ✅
`Dora` | `is-IS` | `female` | ✅
`Karl` | `is-IS` | `male` | ✅
`Carla` | `it-IT` | `female` | ✅
`Giorgio` | `it-IT` | `male` | ✅
`Liv` | `nb-NO` | `female` | ✅
`Lotte` | `nl-NL` | `female` | ✅
`Ruben` | `nl-NL` | `male` | ✅
`Jacek` | `pl-PL` | `male` | ✅
`Ewa` | `pl-PL` | `female` | ✅
`Jan` | `pl-PL` | `male` | ✅
`Maja` | `pl-PL` | `female` | ✅
`Vitoria` | `pt-BR` | `female` | ✅
`Ricardo` | `pt-BR` | `male` | ✅
`Cristiano` | `pt-PT` | `male` | ✅
`Ines` | `pt-PT` | `female` | ✅
`Carmen` | `ro-RO` | `female` | ✅
`Maxim` | `ru-RU` | `male` | ✅
`Tatyana` | `ru-RU` | `female` | ✅
`Astrid` | `sv-SE` | `female` | ✅
`Filiz` | `tr-TR` | `female` | ✅
`Mizuki` | `ja-JP` | `female` | ✅
`Laila` | `ara-XWW` | `female` | ❎
`Maged` | `ara-XWW` | `male` | ❎
`Tarik` | `ara-XWW` | `male` | ❎
`Damayanti` | `ind-IDN` | `female` | ❎
`Miren` | `baq-ESP` | `female` | ❎
`Sin-Ji` | `yue-CHN` | `female` | ❎
`Jordi` | `cat-ESP` | `male` | ❎
`Montserrat` | `cat-ESP` | `female` | ❎
`Iveta` | `ces-CZE` | `female` | ❎
`Zuzana` | `ces-CZE` | `female` | ❎
`Tessa` | `eng-ZAF` | `female` | ❎
`Satu` | `fin-FIN` | `female` | ❎
`Melina` | `ell-GRC` | `female` | ❎
`Nikos` | `ell-GRC` | `male` | ❎
`Carmit` | `heb-ISR` | `female` | ❎
`Lekha` | `hin-IND` | `female` | ❎
`Mariska` | `hun-HUN` | `female` | ❎
`Sora` | `kor-KOR` | `female` | ❎
`Tian-Tian` | `cmn-CHN` | `female` | ❎
`Mei-Jia` | `cmn-TWN` | `female` | ❎
`Nora` | `nor-NOR` | `female` | ❎
`Henrik` | `nor-NOR` | `male` | ❎
`Luciana` | `por-BRA` | `female` | ❎
`Felipe` | `por-BRA` | `male` | ❎
`Catarina` | `por-PRT` | `female` | ❎
`Joana` | `por-PRT` | `female` | ❎
`Ioana` | `ron-ROU` | `female` | ❎
`Laura` | `slk-SVK` | `female` | ❎
`Alva` | `swe-SWE` | `female` | ❎
`Oskar` | `swe-SWE` | `male` | ❎
`Kanya` | `tha-THA` | `female` | ❎
`Cem` | `tur-TUR` | `male` | ❎
`Yelda` | `tur-TUR` | `female` | ❎
`Empar` | `spa-ESP` | `female` | ❎

#### Discontinued voices

Some voices have been removed. The table below shows the discontinued voice names and which voice you will now get if you use the discontinued voice name.

Name | Locale & Gender | Now redirects to
-----|-----------------|-----------------
`Chipmunk` | `en-US`, male | `Justin`
`Eric` | `en-US`, male | `Justin`
`Jennifer` | `en-US`, female | `Kimberly`
`Agnieszka` | `pl-PL`, female | `Ewa`

<a name="stream"></a>
## Stream
The `stream` action allows you to send an audio stream to a Conversation

By default, the talk action is synchronous. However, if you set *bargeIn* to *true* you must set an *input* action later in the NCCO stack.  

The following NCCO example shows how to send an audio stream to a Conversation or Call:

```tabbed_content
source: '/_examples/voice/guides/ncco-reference/stream'
```

You can use the following options to control a *stream* action:

Option | Description | Required
-- | -- | --
`streamUrl` | An array containing a single URL to an mp3 or wav (16-bit) audio file to stream to the Call or Conversation. | Yes
`level` |  Set the audio level of the stream in the range -1 >=level<=1 with a precision of 0.1. The default value is *0*. | No
`bargeIn` | Set to *true* so this action is terminated when the user presses a button on the keypad. Use this feature to enable users to choose an option without having to listen to the whole message in your [Interactive Voice Response (IVR](/voice/guides/interactive-voice-response) ). If you set `bargeIn` to `true` on one more Stream actions then the next action in the NCCO stack **must** be an `input` action. The default value is `false`. | No
`loop` | The number of times `audio` is repeated before the Call is closed. The default value is `1`. Set to `0` to loop infinitely. | No

The audio stream referred to should be a file in MP3 or WAV format. If you have issues with the file playing, please encode it to the following technical specification:

MP3:

* MPEG Audio Layer 3, version 2
* Constant bit rate
* Bit rate: 16 Kbps (8, 32, 64 also supported)
* Sampling rate: 16.0 KHz
* 1 channel
* Lossy compression
* Stream size: 10.1 KiB (91%)
* Encoded with LAME 3.99.5

WAV:

* 8 or 16-bit Linear PCM
* G.711 A-law/u-law
* Microsoft GSM

## `input`

You can use the `input` action to collect digits input by the person you are calling. This action is synchronous, Nexmo processes the input and forwards it in the [parameters](#input-return-parameters) sent to the `eventURL` webhook endpoint you configure in your request. Your webhook endpoint should return another NCCO that replaces the existing NCCO and controls the Call based on the user input. You could use this functionality to create an Interactive Voice Response (IVR). For example, if your user presses *4*, you return a [connect](#connect) NCCO that forwards the call to your sales department.

The following NCCO example shows how to configure an IVR endpoint:

```json
[
  {
    "action": "talk",
    "text": "Please enter a digit"
  },
  {
    "action": "input",
    "eventUrl": ["https://example.com/ivr"]
  }
]
```

The following NCCO example shows how to use `bargeIn` to allow a user to interrupt a `talk` action. Note that an `input` action **must** follow any action that has a `bargeIn` property (e.g. `talk` or `stream`).

```json
[
  {
    "action": "talk",
    "text": "Please enter a digit",
    "bargeIn": true
  },
  {
    "action": "input",
    "eventUrl": ["https://example.com/ivr"]
  }
]
```

The following options can be used to control an `input` action:

Option | Description | Required
-- | -- | --
`timeOut` | The result of the callee's activity is sent to the `eventUrl` webhook endpoint `timeOut` seconds after the last action. The default value is *3*. Max is 10.| No
`maxDigits` | The number of digits the user can press. The maximum value is `20`, the default is `4` digits. | No
`submitOnHash` | Set to `true` so the callee's activity is sent to your webhook endpoint at `eventUrl` after he or she presses *#*. If *#* is not pressed the result is submitted after `timeOut` seconds. The default value is `false`. That is, the result is sent to your webhook endpoint after `timeOut` seconds. | No
`eventUrl` | Nexmo sends the digits pressed by the callee to this URL after `timeOut` pause in activity or when *#* is pressed.  | No
`eventMethod` | The HTTP method used to send event information to `event_url` The default value is POST.| No

The following example shows the parameters sent to `eventUrl`:

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "conversation_uuid": "bbbbbbbb-cccc-dddd-eeee-0123456789ab",
  "timed_out": true,
  "dtmf": "1234",
  "timestamp": "2020-01-01T14:00:00.000Z"
}
```

#### Input Return Parameters
Input parameters which are returned to the `eventUrl` are:

Name | Description
-- | --
`uuid` | The unique ID of the Call leg for the user initiating the input.
`conversation_uuid` | The unique ID for this conversation.
`timed_out` | Returns `true` if this input timed out based on the value of [timeOut](#timeOut).
`dtmf` | The numbers input by your callee, in order.


## Status Codes

The following HTTP codes are supported:

Status | Description
-- | --
`200` | Success
`201` | Resource created
`204` | No content
`401` | Unauthorised
`404` | Not found
`429` | Rate limited
`500` | Nexmo server error

The error format is standardised to the 4xx/5xx range with a code and a human readable explanation. For example, for an authentication failure.
