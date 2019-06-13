---
title: Text to Speech
description: Using our Text-To-Speech engine, you can play machine-generated speech to your callers
navigation_weight: 3
---

# Text to Speech

## Overview

Nexmo uses text-to-speech engines to allow you to play machine
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
    "voiceName": "Amy",
    "text": "Thank you for calling Nexmo. Please leave your message after the tone."
  }
]
```
## Locale

You should choose a voice that matches the language type of the text
you are asking to be read, trying to read Spanish with an `en-us`
voice for example will not produce good results. For many languages
Nexmo offers a choice of voices with different styles and genders.

You can set the Voice with a Voice Name parameter in the talk command,
if you do not specify a voice name then nexmo will default to
`Kimberly`, an `en-US` voice.

### Voice Names

Name | Language | Gender | [SSML](/voice/voice-api/guides/customizing-tts) support
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
`Matthew` | `en-US` | `male` | ✅
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
`Aditi` | `hi-IN` | `female` | ✅
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
`Seoyeon`| `ko-KR` | `female`| ✅
`Laila` | `ara-XWW` | `female` | ❌
`Maged` | `ara-XWW` | `male` | ❌
`Tarik` | `ara-XWW` | `male` | ❌
`Damayanti` | `ind-IDN` | `female` | ❌
`Miren` | `baq-ESP` | `female` | ❌
`Sin-Ji` | `yue-CHN` | `female` | ❌
`Jordi` | `cat-ESP` | `male` | ❌
`Montserrat` | `cat-ESP` | `female` | ❌
`Iveta` | `ces-CZE` | `female` | ❌
`Zuzana` | `ces-CZE` | `female` | ❌
`Tessa` | `eng-ZAF` | `female` | ❌
`Satu` | `fin-FIN` | `female` | ❌
`Melina` | `ell-GRC` | `female` | ❌
`Nikos` | `ell-GRC` | `male` | ❌
`Carmit` | `heb-ISR` | `female` | ❌
`Lekha` | `hin-IND` | `female` | ❌
`Mariska` | `hun-HUN` | `female` | ❌
`Sora` | `kor-KOR` | `female` | ❌
`Tian-Tian` | `cmn-CHN` | `female` | ❌
`Mei-Jia` | `cmn-TWN` | `female` | ❌
`Nora` | `nor-NOR` | `female` | ❌
`Henrik` | `nor-NOR` | `male` | ❌
`Luciana` | `por-BRA` | `female` | ❌
`Felipe` | `por-BRA` | `male` | ❌
`Catarina` | `por-PRT` | `female` | ❌
`Joana` | `por-PRT` | `female` | ❌
`Ioana` | `ron-ROU` | `female` | ❌
`Laura` | `slk-SVK` | `female` | ❌
`Alva` | `swe-SWE` | `female` | ❌
`Oskar` | `swe-SWE` | `male` | ❌
`Kanya` | `tha-THA` | `female` | ❌
`Cem` | `tur-TUR` | `male` | ❌
`Yelda` | `tur-TUR` | `female` | ❌
`Empar` | `spa-ESP` | `female` | ❌

#### Discontinued voices

Some voices have been removed. The table below shows the discontinued
voice names and which voice you will now get if you use the
discontinued voice name.

Name | Locale | Gender | Now redirects to
-----|--------|--------|-----------------
`Chipmunk` | `en-US` | `male` | `Justin`
`Eric` | `en-US` | `male` | `Justin`
`Jennifer` | `en-US` | `female` | `Kimberly`
`Agnieszka` | `pl-PL` | `female` | `Ewa`

