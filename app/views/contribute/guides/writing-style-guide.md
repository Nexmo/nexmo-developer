---
title: Writing style guide
navigation_weight: 2
---

# Writing style guide

These are technical writing guidelines that can be used across all Nexmo technical documentation as well as blog posts.

These guidelines are designed to improve clarity and consistency. Some of the benefits of writing in this style are:

* Easier to read and understand, especially for readers whose first language is not English.
* More professional appearance.
* Easier to translate.

As with most guidelines these are suggestions, not hard and fast rules. Use your best judgement.

## Use present tense

Use present tense. It’s easier to read and translate.

Examples:

* *Future:* Command X will start the server.
* *Present:* Command X starts the server.

## Use simple language

Use clear, simple, and direct language. Avoid flowery and verbose writing styles.

* Avoid filler words and superfluous adjectives 'really nice feature', 'easily', ‘simple’, 'just', 'please', 'it may be that', 'and that's it'.
* Avoid subjective phrases. "You can easily...". "It is simple to...".

## Use active voice

Use active voice. In active voice the *Subject* *Verbs* the *Object*. Remember SVO.

Examples:

* *Active voice:* The man ate the apple.
* *Passive voice:* The apple was eaten by the man.
* *Active voice:* The NCCO controls the call.
* *Passive voice:* The call is controlled by the NCCO.
* *Active voice:* Nexmo provides a Messages API.
* *Passive voice:* A Messages API is provided by Nexmo.

## Paragraph breaks

In technical writing, and especially blog posts, you can be a little more generous with your use of paragraph breaks. They make the text less overwhelming and easier to read.

## Avoid vague and cautious language

Avoid words like would, should, might and so on.

Example:

* *Avoid:* If you run the Nexmo CLI with no parameters you might see some text, or possibly an error, or something!
* *Better:* If you run the Nexmo CLI without specifying parameters a help message is displayed.

## Use second person

Use 'you' rather than 'we' when referring to the reader.

Example:

* *Avoid:* We now need to enter an API Key.
* *Better:* You now need to enter an API Key.
* *Avoid:* We can now click the button to register our Nexmo Number.
* *Better:* You can now click the button to register your Nexmo Number.
* *Best:* Click the button to register your Nexmo Number.

Use Nexmo rather than 'we' when referring to the company.

Example:

* *Avoid:* We also provide an SMS API.
* *Better:* Nexmo also provides an SMS API.

## Use American English

The company standard is, as with most software companies, to use American English.

The industry standard dictionary is [Merriam Webster](https://www.merriam-webster.com/).

## Avoid Latin phrases and slang

Latin phrases and abbreviations can sometimes cause confusion. They can also be less convenient to translate.

Examples:

* Use ‘for example’, instead of 'e.g.' and 'that is' rather than 'i.e.'.
* Don't use words like 'crash', use 'error'. Use 'launch' or 'start' rather than 'fire up'.
* Bear in mind the reader’s first language may not be English.
* Mouse is clicked and keyboard is pressed. Avoid terms such as 'hit' when referring to the keyboard.

## Headings

Be consistent.

For example:

* Use word case for documentation main sections. For example, 'Building Blocks'.
* Use sentence case for section headings. For example, 'This is a section heading'.

## Bulleted lists

This is an example of a bulleted list:

* Precede a list with a sentence and a colon.
* Terminate each sentence in a list with a full stop.
* Use bulleted lists for lists.
* Use numbered lists for ordered sequences (procedures, tasks and so on).

## Codeblocks

When inserting codeblocks for example code in the text:

* Specify the coding language where possible.
* Break the text before a codeblock with a colon, not a period (which is a hard stop in the mind of the reader, rather than a continuation).
* There should not be a space before the colon.

## Three Letter Acronyms (TLAs)

Define Three Letter Acronyms (TLAs) before first use. On subsequent use on a page/section you do not need to redefine the TLA.

## Be explicit

Try to be explicit, that is use precise terms where necessary to improve clarity and avoid ambiguity.

Examples:

* Using 'Nexmo Number' rather than 'number'.
* Using 'Nexmo Application' rather than 'application'.
* Using 'web application' rather than 'application'.
* Using 'webhook server' rather than 'server' or 'application'.
* Using 'webhook URL' rather than 'endpoint' or 'callback URL'.
* Using Nexmo Client Library rather than 'library'.
* Using Nexmo Command Line Interface, or Nexmo CLI, rather than 'command line'.

## Avoid using 'he or she' constructs

Avoid "He or she" (use user/developer/caller as appropriate). Do not replace 'he or she' by 'they'.

Example:

* *Avoid:* The user answers the phone and then he or she hears a voice.
* *Avoid:* The user answers the phone and then they hear a voice.
* *Better:* The user answers the phone and then the user hears a voice.
* *Best:* The user answers the phone and then hears a voice.

## Miscellaneous

Some additional points to bear in mind:

* Explain to the reader *why* they need a particular feature and not just what the feature is.
* Avoid statements that predict the future, for example, "the next version will have feature X". There are good legal reasons for avoiding predicting the future.
* Avoid time sensitive information. Specify an exact version where possible, for example '1.1', rather than 'current version' as the current version may change.
* Avoid using ampersand ('&') instead of 'and', unless you are specifying a programming language operator or similar.
* "It's" is _always_ 'it is'.

## Replaceable values

When working with keys, phone numbers, or accounts be clear where values should be replaced by customer-specific values. 

Key | Markdown Value | Rendered Value  <small>(if different)</small>
-- | -- | --
Timestamp | `2020-01-01 12:00:00` | -
ISO8601 Timestamp | `2020-01-01T12:00:00.000Z` | -
Epoch | `1577880000` | -
HTTP Method | ``[GET]`` or ``[POST]`` | [GET] or [POST]
HTTP Response | `` `200 OK` `` or §§ `` `404 Not Found` `` | `200 OK` or §§ `404 Not Found`
Balance | `3.14159` | -
Latency | `3000` | -
UUID | `aaaaaaaa-bbbb-cccc-dddd-0123456789ab` | -
SNS ARN | `arn:aws:sns:us-east-1:01234567890:example` | -

## Numbers

When use of a real phone number can't be avoided, for example when listing out the result of `nexmo numbers:list` in the CLI, use the following numbers:

### US Numbers

Human readable format | E.164 format
-- | --
`(415) 555-0100` | `14155550100`
`(415) 555-0101` | `14155550101`
`(415) 555-0102` | `14155550102`
`(415) 555-0103` | `14155550103`
`(415) 555-0104` | `14155550104`
`(415) 555-0105` | `14155550105`

### GB Numbers

Human readable format | E.164 format
-- | --
`020 7946 0000` | `442079460000`
`020 7946 0001` | `442079460001`
`020 7946 0002` | `442079460002`
`020 7946 0003` | `442079460003`
`020 7946 0004` | `442079460004`
`020 7946 0005` | `442079460005`

### GB Mobile Numbers

Human readable format | E.164 format
-- | --
`07700 900000` | `447700900000`
`07700 900001` | `447700900001`
`07700 900002` | `447700900002`
`07700 900003` | `447700900003`
`07700 900004` | `447700900004`
`07700 900005` | `447700900005`

## Examples of writing style guides

Some further examples of writing style guides are:

* [Microsoft Style for Technical Publications](https://books.google.co.uk/books/about/The_Microsoft_Manual_of_Style_for_Techni.html)
* [Magento](http://devdocs.magento.com/guides/v2.0/contributor-guide/contributing_docs.html)
* [Kubernetes](https://kubernetes.io/docs/home/contribute/style-guide/)
* [.NET](https://github.com/dotnet/docs/blob/master/styleguide/voice-tone.md)
