---
title: Customizing Spoken Text
description: Use Speech Synthesis Markup Language (SSML) to control how text-to-speech is read out
navigation_weight: 4
---

# Customizing Spoken Text

## Overview

You can control how the Nexmo Voice API plays machine-generated text to your users by using a subset of the tags defined in the [Speech Synthesis Markup Language (SSML) specification](https://www.w3.org/TR/speech-synthesis11/). This XML-based markup enables you to mix multiple languages, provide pronunciation hints for specific words and numbers and control the speed, volume and pitch of synthesized text.

In an [NCCO](/voice/voice-api/ncco-reference) `talk` action, you can send [SSML tags](#ssml-tags) as
part of the text string. But first, you must surround the entire string in `<speak></speak>` tags to tell Nexmo that the string includes SSML. You may use either single quotes or escaped double quotes for tag attribute values.

Here is an example of SSML in the `text` property of a NCCO `talk` action:

```json
[
  {
    "action": "talk",
    "text": "<speak><lang xml:lang='es-ES'>Hola!</lang></speak>"
  }
]
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/01-hola.mp3]


## SSML tags

* [Breaks](#breaks): Add breaks (pauses) to spoken text
* [Language](#language): Specify the language to use in Text-to-Speech
* [Phonemes](#phonemes): Spell out the text using the [phonetic alphabet](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet)
* [Prosody](#prosody): Set the pitch, speed and volume of the spoken text
* [Say as](#say-as): Provide pronunciation hints for words, numbers and dates
* [Sentences and paragraphs](#sentences-and-paragraphs): Force the API to recognize sentences and paragraphs when speaking your text
* [Substitution](#substitution): Replace specific text with a pronunciation of your choice


### Breaks

The `break` tag allows you to add pauses to text. The duration of the
pause can be specified either using a `strength` duration or as a
`time` seconds or milliseconds.

```xml
<speak>My name is <break time='1s' />Slim Shady.</speak>
```

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

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/02-langage.mp3]


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

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/06-phonemes.mp3]


### Prosody

The `prosody` tag allows you to set the pitch, rate and volume of the
text.

* The `volume` attribute can be set to the following values: `default`,
`silent`, `x-soft`, `soft`, `medium`, `loud` and `x-loud`. You can
also specify a relative decibel value in the form `+ndB` or `-nDB`
where `n` is an integer value.

* The `rate` attribute changes the speed of speech. Acceptable values
include: `x-slow`, `slow`, `medium`, `fast` and `x-fast`.
* The `pitch` attribute changes the pitch of the voice. You can specify
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

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/07-prosody.mp3]


### Say As

The `say-as` tag allows you to provide instructions for how particular words and numbers are spoken. Many of these features are automatically detected in speech by the TTS engine, but the `say-as` command allows you to mark them specifically.

The `say-as` tag has a required attribute: `interpret-as`. That attribute must contain one of the following values:

Value of `interpret-as`  | Effect on spoken text
--|--
`character`/`spell-out` | Spells each letter out, for example: `I-A-T-A`.
`cardinal`/`number` | Pronounces the value as a number. For example, "974" would be pronounced "nine hundred and seventy four".
`ordinal` | Pronounces the number as an ordinal. For example, "1" would be pronounced "first" and "33" would be pronounced "thirty-third".
`digits` | Reads the specified numbers out as digits. For example, "747" would be pronounced "seven four seven" and not "seven hundred and forty seven".
`fraction` | Reads the numbers out as a fraction. For example, "1/3" would be pronounced "one third" and "2 4/10" would be pronounced "two and four tenths".
`unit` | Reads the specified number out as a unit. The value must be a number followed by a unit of measure with no space between the two. For example: "1meter".
`date` | Specify how to pronounce dates. See the section below on [date formatting](#date-formatting).
`time` | Pronounces time durations in minutes and seconds. For example: `1'30"` is read as "one minute and thirty seconds".
`address` | Reads out a street address with appropriate breaks.
`expletive` | Replaces the content with a "bleep" to censor expletives. You can use this to automatically substitute filtered swear words.
`telephone` | Reads out a telephone number with appropriate breaks.

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

`format` | How date is read out
--|--
`mdy` | month-date-year (e.g. "3/10/2019")
`dmy` | day-month-year (e.g. "10/3/2019")
`ymd` | year-month-day (e.g. "2019/3/10")
`md` | month-day (e.g. "3/10")
`dm` | day-month (e.g. "10/3")
`ym` | year-month (e.g. "2019/3")
`my` | month-year (e.g. "3/2019")
`d` | day (e.g. "10")
`m` | month (e.g. "3")
`y` | year (e.g. "2019")
`yyyymmdd` | year-month-day, with optional `?` to replace unspecified components. For example: `20190310` or `????0310`.

The example below will be converted to "Today is March 10th".

```xml
<speak>
Today is <say-as interpret-as="date" format="dm">10/3</say-as>
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/09-interpret-as-date.mp3]


### Sentences and paragraphs

#### Sentences

You can wrap sentences in the `s` tag. This is equivalent to putting a
full stop at the end of the sentence.

```xml
<speak>
<s>Thank you Mario</s>
<s>But our princess is in another castle</s>
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/08-sentences.mp3]

#### Paragraphs

The `p` tag allows you to specify paragraphs in your speech.

```xml
<speak>
<p>Hello.</p>
<p>How are you?</p>
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/05-paragraphs.mp3]


### Substitution

The `sub` tag allows you to provide a substitute pronunciation. The contents of the `alias` attribute will be read instead.

```xml
<speak>
Welcome to the <sub alias="United States">US</sub>.
</speak>
```

🔈[https://nexmo-developer-production.s3.amazonaws.com/assets/ssml/10-alias.mp3]
