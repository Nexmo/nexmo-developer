---
title: Text to Speech
description: Using our Text-To-Speech engine, you can play machine-generated speech to your callers
navigation_weight: 3
---

# Text to Speech

## Overview

Vonage uses text-to-speech engines to allow you to play machine
generated speech to your users. This can either be done via an NCCO
with the use of the `talk` action, or by [making a PUT request](/api/voice#startTalk) to an
in-progress call.

> You can customize how speech is read out by using [Speech Synthesis Markup Language (SSML)](/voice/voice-api/guides/customizing-tts)

## Example

The following example NCCO shows a simple use case:

``` json
[
  {
    "action": "talk",
    "text": "Thank you for calling. Please leave your message after the tone."
  }
]
```
## Locale

You should choose a locale that matches the language type of the text
you are asking to be read, trying to read Spanish with an `en-us`
voice for example will not produce good results.

You can set the language code ([BCP-47](https://tools.ietf.org/html/bcp47)) with a `language` parameter in the `talk` command,
if you do not specify a language then Vonage will default to an `en-US` voice. 
For many languages Vonage offers a choice of voices with different styles. The `style` parameter maps to features such as 
vocal range, timbre and tessitura of the selected voice. You can experiment with different styles to find the one appropriate
for your use case. You can choose a specific voice style by using the `style` parameter. By default, the first style (`0`) is used.
Please note not all the voice styles support [SSML](/voice/voice-api/guides/customizing-tts), 
see the list of all the supported languages and SSML enabled styles below.

NCCO example with specific voice language and style:

``` json
[
  {
    "action": "talk",
    "text": "Obrigado pela sua chamada. Por favor, deixe sua mensagem após o sinal.",
    "language": "pt-PT",
    "style": 6
  }
]
```

### Supported Languages

Language | Code | Styles | [SSML](/voice/voice-api/guides/customizing-tts) Support (Styles)
-- | -- | -- | -- 
Arabic | `ar` | `0` - `6` | `0`, `1`, `3`, `4`
Basque (Spain) | `eu-ES` | `0` | -
Catalan, Valencian | `ca-ES` | `0` - `1` | -
Chinese, Cantonese | `yue-CN` | `0` | -
Chinese, Mandarin | `cmn-CN` | `0` - `5` | `0`, `1`, `2`, `4`, `5`
Chinese, Mandarin (Taiwan) | `cmn-TW` | `0` | -
Czech | `cs-CZ` | `0` - `2` | `0`
Danish | `da-DK` | `0` - `2` | `0` - `2`
Dutch | `nl-NL` | `0` - `6` | `0` - `6`
English (Australia) | `en-AU` | `0` - `5` | `0` - `5`
English (India) | `en-IN` | `0` - `4` | `0` - `4`
English (South Africa) | `en-ZA` | `0` | -
English (United Kingdom) | `en-GB` | `0` - `6` | `0` - `6`
English (United States) | `en-US` | `0` - `11` | `0` - `11`
English (Wales) | `en-GB-WLS` | `0` | -
Filipino | `fil-PH` | `0` | `0`
Finnish | `fi-FI` | `0` - `1` | `0`
French (Canada) | `fr-CA` | `0` - `4` | `0` - `4`
French (France) | `fr-FR` | `0` - `7` | `0` - `7`
German | `de-DE` | `0` - `4` | `0` - `4`
Greek | `el-GR` | `0` - `2` | `0`
Hebrew | `he-IL` | `0` | -
Hindi | `hi-IN` | `0` - `4` | `0`, `1`, `3`, `4`
Hungarian | `hu-HU` | `0` - `1` | `0`
Icelandic | `is-IS` | `0` - `1` | `0` - `1`
Indonesian | `id-ID` | `0` - `3` | `0`, `2`, `3`
Italian | `it-IT` | `0` - `6` | `0` - `6`
Japanese | `ja-JP` | `0` - `5` | `0` - `5`
Korean | `ko-KR` | `0` - `5` | `0`, `1`, `2`, `4`, `5`
Norwegian | `no-NO` | `0` - `1` | -
Norwegian Bokmål | `nb-NO` | `0` - `5` | `0` - `5`
Polish | `pl-PL` | `0` - `8` | `0` - `8`
Portuguese (Brazil) | `pt-BR` | `0` - `4` | `0`, `1`, `3`
Portuguese (Portugal) | `pt-PT` | `0` - `7` | `0` - `2`, `5` - `7`
Romanian | `ro-RO` | `0` - `1` | `0`
Russian | `ru-RU` | `0` - `6` | `0` - `6`
Slovak | `sk-SK` | `0` - `1` | `0`
Spanish (Mexico) | `es-MX` | `0` | `0`
Spanish (Spain) | `es-ES` | `0` - `4` | `0`, `1`, `2`, `4`
Spanish (United States) | `es-US` | `0` - `1` | `0` - `1`
Swedish | `sv-SE` | `0` - `3` | `0` - `1`
Thai | `th-TH` | `0` | -
Turkish | `tr-TR` | `0` - `7` | `0` - `3`, `5` - `6`
Ukrainian | `uk-UA` | `0` | `0`
Vietnamese | `vi-VN` | `0` - `3` | `0` - `3`
Welsh | `cy-GB` | `0` | `0`
