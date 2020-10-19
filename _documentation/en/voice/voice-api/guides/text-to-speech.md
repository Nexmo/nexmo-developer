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

Language | Code | Style | [SSML](/voice/voice-api/guides/customizing-tts) Support | Sample
-- | -- | -- | -- | --
Arabic | ar | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-0.mp3]
Arabic | ar | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-1.mp3]
Arabic | ar | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-2.mp3]
Arabic | ar | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-3.mp3]
Arabic | ar | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-4.mp3]
Arabic | ar | 5 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-5.mp3]
Arabic | ar | 6 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-6.mp3]
Arabic | ar | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ar-7.mp3]
Basque | eu-ES | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/eu-ES-0.mp3]
Bengali | bn-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/bn-IN-0.mp3]
Bengali | bn-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/bn-IN-1.mp3]
Catalan, Valencian | ca-ES | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ca-ES-0.mp3]
Catalan, Valencian | ca-ES | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ca-ES-1.mp3]
Chinese, Cantonese | yue-CN | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/yue-CN-0.mp3]
Chinese, Mandarin | cmn-CN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-0.mp3]
Chinese, Mandarin | cmn-CN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-1.mp3]
Chinese, Mandarin | cmn-CN | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-2.mp3]
Chinese, Mandarin | cmn-CN | 3 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-3.mp3]
Chinese, Mandarin | cmn-CN | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-4.mp3]
Chinese, Mandarin | cmn-CN | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-CN-5.mp3]
Chinese, Mandarin (Taiwan) | cmn-TW | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-TW-0.mp3]
Chinese, Mandarin (Taiwan) | cmn-TW | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-TW-1.mp3]
Chinese, Mandarin (Taiwan) | cmn-TW | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-TW-2.mp3]
Chinese, Mandarin (Taiwan) | cmn-TW | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cmn-TW-3.mp3]
Czech | cs-CZ | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cs-CZ-0.mp3]
Czech | cs-CZ | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cs-CZ-1.mp3]
Czech | cs-CZ | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cs-CZ-2.mp3]
Danish | da-DK | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-0.mp3]
Danish | da-DK | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-1.mp3]
Danish | da-DK | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-2.mp3]
Danish | da-DK | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-3.mp3]
Danish | da-DK | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-4.mp3]
Danish | da-DK | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/da-DK-5.mp3]
Dutch | nl-NL | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-0.mp3]
Dutch | nl-NL | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-1.mp3]
Dutch | nl-NL | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-2.mp3]
Dutch | nl-NL | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-3.mp3]
Dutch | nl-NL | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-4.mp3]
Dutch | nl-NL | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-5.mp3]
Dutch | nl-NL | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nl-NL-6.mp3]
English (Australia) | en-AU | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-0.mp3]
English (Australia) | en-AU | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-1.mp3]
English (Australia) | en-AU | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-2.mp3]
English (Australia) | en-AU | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-3.mp3]
English (Australia) | en-AU | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-4.mp3]
English (Australia) | en-AU | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-AU-5.mp3]
English (India) | en-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-0.mp3]
English (India) | en-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-1.mp3]
English (India) | en-IN | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-2.mp3]
English (India) | en-IN | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-3.mp3]
English (India) | en-IN | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-4.mp3]
English (India) | en-IN | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-IN-5.mp3]
English (South Africa) | en-ZA | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-ZA-0.mp3]
English (United Kingdom) | en-GB | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-0.mp3]
English (United Kingdom) | en-GB | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-1.mp3]
English (United Kingdom) | en-GB | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-2.mp3]
English (United Kingdom) | en-GB | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-3.mp3]
English (United Kingdom) | en-GB | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-4.mp3]
English (United Kingdom) | en-GB | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-5.mp3]
English (United Kingdom) | en-GB | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-6.mp3]
English (United Kingdom) | en-GB | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-7.mp3]
English (United States) | en-US | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-0.mp3]
English (United States) | en-US | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-1.mp3]
English (United States) | en-US | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-2.mp3]
English (United States) | en-US | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-3.mp3]
English (United States) | en-US | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-4.mp3]
English (United States) | en-US | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-5.mp3]
English (United States) | en-US | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-6.mp3]
English (United States) | en-US | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-7.mp3]
English (United States) | en-US | 8 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-8.mp3]
English (United States) | en-US | 9 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-9.mp3]
English (United States) | en-US | 10 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-10.mp3]
English (United States) | en-US | 11 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-US-11.mp3]
English (Wales) | en-GB-WLS | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/en-GB-WLS-0.mp3]
Filipino | fil-PH | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fil-PH-0.mp3]
Filipino | fil-PH | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fil-PH-1.mp3]
Filipino | fil-PH | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fil-PH-2.mp3]
Filipino | fil-PH | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fil-PH-3.mp3]
Finnish | fi-FI | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fi-FI-0.mp3]
Finnish | fi-FI | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fi-FI-1.mp3]
French (Canada) | fr-CA | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-CA-0.mp3]
French (Canada) | fr-CA | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-CA-1.mp3]
French (Canada) | fr-CA | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-CA-2.mp3]
French (Canada) | fr-CA | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-CA-3.mp3]
French (Canada) | fr-CA | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-CA-4.mp3]
French (France) | fr-FR | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-0.mp3]
French (France) | fr-FR | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-1.mp3]
French (France) | fr-FR | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-2.mp3]
French (France) | fr-FR | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-3.mp3]
French (France) | fr-FR | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-4.mp3]
French (France) | fr-FR | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-5.mp3]
French (France) | fr-FR | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-6.mp3]
French (France) | fr-FR | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/fr-FR-7.mp3]
German | de-DE | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-0.mp3]
German | de-DE | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-1.mp3]
German | de-DE | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-2.mp3]
German | de-DE | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-3.mp3]
German | de-DE | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-4.mp3]
German | de-DE | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-5.mp3]
German | de-DE | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/de-DE-6.mp3]
Greek | el-GR | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/el-GR-0.mp3]
Greek | el-GR | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/el-GR-1.mp3]
Greek | el-GR | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/el-GR-2.mp3]
Gujarati | gu-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/gu-IN-0.mp3]
Gujarati | gu-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/gu-IN-1.mp3]
Hebrew | he-IL | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/he-IL-0.mp3]
Hindi | hi-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-0.mp3]
Hindi | hi-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-1.mp3]
Hindi | hi-IN | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-2.mp3]
Hindi | hi-IN | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-3.mp3]
Hindi | hi-IN | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-4.mp3]
Hindi | hi-IN | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-5.mp3]
Hindi | hi-IN | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-7.mp3]
Hindi  | hi-IN | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hi-IN-6.mp3]
Hungarian | hu-HU | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hu-HU-0.mp3]
Hungarian | hu-HU | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/hu-HU-1.mp3]
Icelandic | is-IS | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/is-IS-0.mp3]
Icelandic | is-IS | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/is-IS-1.mp3]
Indonesian | id-ID | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/id-ID-0.mp3]
Indonesian | id-ID | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/id-ID-1.mp3]
Indonesian | id-ID | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/id-ID-2.mp3]
Indonesian | id-ID | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/id-ID-3.mp3]
Indonesian | id-ID | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/id-ID-4.mp3]
Italian | it-IT | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-0.mp3]
Italian | it-IT | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-1.mp3]
Italian | it-IT | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-2.mp3]
Italian | it-IT | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-3.mp3]
Italian | it-IT | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-4.mp3]
Italian | it-IT | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-5.mp3]
Italian | it-IT | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/it-IT-6.mp3]
Japanese | ja-JP | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-0.mp3]
Japanese | ja-JP | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-1.mp3]
Japanese | ja-JP | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-2.mp3]
Japanese | ja-JP | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-3.mp3]
Japanese | ja-JP | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-4.mp3]
Japanese | ja-JP | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ja-JP-5.mp3]
Kannada | kn-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/kn-IN-0.mp3]
Kannada | kn-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/kn-IN-1.mp3]
Korean | ko-KR | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-0.mp3]
Korean | ko-KR | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-1.mp3]
Korean | ko-KR | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-2.mp3]
Korean | ko-KR | 3 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-3.mp3]
Korean | ko-KR | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-4.mp3]
Korean | ko-KR | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ko-KR-5.mp3]
Malayalam | ml-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ml-IN-0.mp3]
Malayalam | ml-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ml-IN-1.mp3]
Norwegian | no-NO | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/no-NO-0.mp3]
Norwegian | no-NO | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/no-NO-1.mp3]
Norwegian Bokmål | nb-NO | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-0.mp3]
Norwegian Bokmål | nb-NO | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-1.mp3]
Norwegian Bokmål | nb-NO | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-2.mp3]
Norwegian Bokmål | nb-NO | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-3.mp3]
Norwegian Bokmål | nb-NO | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-4.mp3]
Norwegian Bokmål | nb-NO | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/nb-NO-5.mp3]
Polish | pl-PL | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-0.mp3]
Polish | pl-PL | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-1.mp3]
Polish | pl-PL | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-2.mp3]
Polish | pl-PL | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-3.mp3]
Polish | pl-PL | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-4.mp3]
Polish | pl-PL | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-5.mp3]
Polish | pl-PL | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-6.mp3]
Polish | pl-PL | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-7.mp3]
Polish | pl-PL | 8 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pl-PL-8.mp3]
Portuguese (Brazil) | pt-BR | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-0.mp3]
Portuguese (Brazil) | pt-BR | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-1.mp3]
Portuguese (Brazil) | pt-BR | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-2.mp3]
Portuguese (Brazil) | pt-BR | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-3.mp3]
Portuguese (Brazil) | pt-BR | 4 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-4.mp3]
Portuguese (Brazil) | pt-BR | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-BR-5.mp3]
Portuguese (Portugal) | pt-PT | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-0.mp3]
Portuguese (Portugal) | pt-PT | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-1.mp3]
Portuguese (Portugal) | pt-PT | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-2.mp3]
Portuguese (Portugal) | pt-PT | 3 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-3.mp3]
Portuguese (Portugal) | pt-PT | 4 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-4.mp3]
Portuguese (Portugal) | pt-PT | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-5.mp3]
Portuguese (Portugal) | pt-PT | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-6.mp3]
Portuguese (Portugal) | pt-PT | 7 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/pt-PT-7.mp3]
Romanian | ro-RO | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ro-RO-0.mp3]
Romanian | ro-RO | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ro-RO-1.mp3]
Russian | ru-RU | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-0.mp3]
Russian | ru-RU | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-1.mp3]
Russian | ru-RU | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-2.mp3]
Russian | ru-RU | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-3.mp3]
Russian | ru-RU | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-4.mp3]
Russian | ru-RU | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-5.mp3]
Russian | ru-RU | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ru-RU-6.mp3]
Slovak | sk-SK | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sk-SK-0.mp3]
Slovak | sk-SK | 1 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sk-SK-1.mp3]
Spanish (Mexico) | es-MX | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-MX-0.mp3]
Spanish (Spain) | es-ES | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-ES-0.mp3]
Spanish (Spain) | es-ES | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-ES-1.mp3]
Spanish (Spain) | es-ES | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-ES-2.mp3]
Spanish (Spain) | es-ES | 3 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-ES-3.mp3]
Spanish (Spain) | es-ES | 4 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-ES-4.mp3]
Spanish (United States) | es-US | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-US-0.mp3]
Spanish (United States) | es-US | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-US-1.mp3]
Spanish (United States) | es-US | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/es-US-2.mp3]
Swedish | sv-SE | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sv-SE-0.mp3]
Swedish | sv-SE | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sv-SE-1.mp3]
Swedish | sv-SE | 2 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sv-SE-2.mp3]
Swedish | sv-SE | 3 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/sv-SE-3.mp3]
Tamil | ta-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ta-IN-0.mp3]
Tamil | ta-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/ta-IN-1.mp3]
Telugu | te-IN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/te-IN-0.mp3]
Telugu | te-IN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/te-IN-1.mp3]
Thai | th-TH | 0 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/th-TH-0.mp3]
Thai | th-TH | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/th-TH-1.mp3]
Turkish | tr-TR | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-0.mp3]
Turkish | tr-TR | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-1.mp3]
Turkish | tr-TR | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-2.mp3]
Turkish | tr-TR | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-3.mp3]
Turkish | tr-TR | 4 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-4.mp3]
Turkish | tr-TR | 5 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-5.mp3]
Turkish | tr-TR | 6 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-6.mp3]
Turkish | tr-TR | 7 |  | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/tr-TR-7.mp3]
Ukrainian | uk-UA | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/uk-UA-0.mp3]
Vietnamese | vi-VN | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/vi-VN-0.mp3]
Vietnamese | vi-VN | 1 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/vi-VN-1.mp3]
Vietnamese | vi-VN | 2 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/vi-VN-2.mp3]
Vietnamese | vi-VN | 3 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/vi-VN-3.mp3]
Welsh | cy-GB | 0 | ✔️ | 🔈[https://raw.githubusercontent.com/vshisterov/tts-samples/master/cy-GB-0.mp3]


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
