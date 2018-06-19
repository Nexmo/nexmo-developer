---
title: Text to Speech
navigation_weight: 3
---

# Overview

Nexmo uses text-to-speech engines to allow you to play machine
generated speech to your users. This can either be done via an NCCO
with the use of the `talk` action, or by [making a PUT request](/api/voice#startTalk) to an
in-progress call.

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

Name | Language | Gender | [SSML](#ssml) support
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

Some voices have been removed. The table below shows the discontinued
voice names and which voice you will now get if you use the
discontinued voice name.

Name | Locale | Gender | Now redirects to
-----|--------|--------|-----------------
`Chipmunk` | `en-US` | `male` | `Justin`
`Eric` | `en-US` | `male` | `Justin`
`Jennifer` | `en-US` | `female` | `Kimberly`
`Agnieszka` | `pl-PL` | `female` | `Ewa`

## SSML

The Nexmo Voice API allows you to send text-to-speech to a call using
a number of tags from the XML-based [Speech Synthesis Markup
Language](https://www.w3.org/TR/speech-synthesis11/)(SSML). This
enables you to mix multiple languages, to control the speed, volume
and pitch of synthesised text, and to control pronunciation of words
and numbers.

In an [NCCO](/api/voice/ncco) `talk` action, you can send SSML tags as
part of the text string. They must all be wrapped in a `speak` root
tag. You may use either single quotes or escaped double quotes around
attribute values on SSML tags.

An example of how the SSML strings are stored inside an NCCO is
provided below:

```json
[
  {
    "action": "talk",
    "text": "<speak><lang xml:lang='es-ES'>Hola!</lang></speak>"
  }
]
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/01-hola.mp3]

### Language

The `lang` tag allows you to control the language used in the
speech. The language tag should contain both the language tag and
country code (e.g. `pt-BR` for Brazilian Portuguese, `en-GB` for
British English), even for languages with no country variations where
a country code might otherwise be redundant (e.g. `it-IT` for
Italian).

```xml
<speak><lang xml:lang='it-IT'>Buongiorno</lang></speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/02-langage.mp3]

### Breaks

The `break` tag allows you to add pauses to text. The duration of the
pause can be specified either using a `strength` duration or as a
`time` seconds or milliseconds.

```xml
<speak>My name is <break time='1s' />Slim Shady.</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/03-breaks-1.mp3]

Valid `strength` values include:

* `none` or `x-weak` (which removes a pause which might otherwise exist after a full stop)
* `weak` or `medium` (equivalent to a comma)
* `strong` or `x-strong` (equivalent to a paragraph break)

```xml
<speak>
To be <break strength='weak' />
or not to be <break strength='weak' />
that is the question.
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/04-breaks-2.mp3]

### Paragraphs

The `p` tag allows you to specify paragraphs in your speech.

```xml
<speak>
<p>Hello.</p>
<p>How are you?</p>
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/05-paragraphs.mp3]

### Phonemes

The `phoneme` tag allows you to send an International Phonetic
Alphabet (IPA) representation of a word. To use this, you need to
specify both an `alphabet` (either `ipa` or
[`x-sampa`](https://en.wikipedia.org/wiki/X-SAMPA)) and the `ph`
attribute containing the phonetic symbols.

```xml
<speak>
<phoneme alphabet='ipa' ph='təˈmætoː'>Tomato</phoneme> or
<phoneme alphabet='ipa' ph='təˈmeɪtoʊ'>tomato</phoneme>.
Two nations separated by a common language.
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/06-phonemes.mp3]

### Prosody

The `prosody` tag allows you to set the pitch, rate and volume of the
text.

The `volume` attribute can be set to the following values: `default`,
`silent`, `x-soft`, `soft`, `medium`, `loud` and `x-loud`. You can
also specify a relative decibel value in the form `+ndB` or `-nDB`
where `n` is an integer value.

The `rate` attribute changes the speed of speech. Acceptable values
include: `x-slow`, `slow`, `medium`, `fast` and `x-fast`.

The `pitch` attribute changes the pitch of the voice. You can specify
this using either predefined value labels or numerically. The value
labels are: `default`, `x-low`, `low`, `medium`, `high` and
`x-high`. The format for specifying a numerical pitch change is: `+n%`
and `-n%`.

The example below shows how to change the volume, rate and pitch.

```xml
<speak>
I am <prosody volume='loud'>loud and proud</prosody>,
<prosody rate='fast'>quick as a cricket</prosody>
and can <prosody pitch='x-low'>change my pitch</prosody>.
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/07-prosody.mp3]

### Sentences

You can wrap sentences in the `s` tag. This is equivalent to putting a
full stop at the end of the sentence.

```xml
<speak>
<s>Thank you Mario</s>
<s>But our princess is in another castle</s>
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/08-sentences.mp3]

### Say As

The `say-as` tag allows you to provide instructions for how particular words and numbers are spoken. Many of these features are automatically detected in speech by the TTS engine, but the `say-as` command allows you to mark them specifically.

The `say-as` tag has a required attribute: `interpret-as`. That attribute must contain one of the following values:

* `character`/`spell-out`: spells each letter out, like `I-A-T-A`
* `cardinal`/`number`: pronounces the value as a number — e.g. "974" would be pronounced "nine hundred and seventy four"
* `ordinal`: pronounces the number as an ordinal — e.g. "1" would be pronounced "first", "33" would be pronounced "thirty-third"
* `digits`: reads the numbers out as digits – e.g. "747" would be pronounced "seven four seven"
* `fraction`: reads the numbers out as a fraction — e.g. "1/3" would be pronounced "one third", "2 4/10" would be pronounced "two and four tenths"
* `unit`: reads number out as a unit. The value must be a number followed by a unit of measure with no space between the two — e.g. "1meter"
* `date`: pronounces date — see section below on date formatting
* `time`: pronounces time durations in minutes and seconds — e.g. `1'30"`
* `address`: reads the street address
* `expletive`: replaces the content with a "bleep" to censor expletives — can be used to automatically substitute in place of filtered swear words
* `telephone`: reads out a telephone number with appropriate breaks.

An example:

```xml
<speak>
On the <say-as interpret-as="ordinal">1</say-as> day of Christmas,
come to <say-as interpret-as="address">123 Main Street</say-as>.
<say-as interpret-as="spell-out">RSVP</say-as> for a mince pie.
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/09-interpret-as.mp3]

#### Date formatting

Dates can be formatted in the following ways:

* `mdy`: month-date-year (e.g. "3/10/2017")
* `dmy`: day-month-year (e.g. "10/3/2017")
* `ymd`: year-month-day (e.g. "2017/3/10")
* `md`: month-day (e.g. "3/10")
* `dm`: day-month (e.g. "10/3")
* `ym`: year-month (e.g. "2017/3")
* `my`: month-year (e.g. "3/2017")
* `d`: day (e.g. "10")
* `m`: month (e.g. "3")
* `y`: year (e.g. "2017")
* `yyyymmdd`: year-month-day, with optional `?` to replace unspecified components (e.g. "20170310" or "????0310")

The example below will be converted to "Today is March 10th".

```xml
<speak>
Today is <say-as interpret-as="date" format="dm">10/3</say-as>
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/09-interpret-as-date.mp3]

### Substitution

The `sub` tag allows you to provide a substitute pronunciation. The contents of the `alias` attribute will be read instead.

```xml
<speak>
Welcome to the <sub alias="United States">US</sub>.
</speak>
```

#### Example

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/10-alias.mp3]
